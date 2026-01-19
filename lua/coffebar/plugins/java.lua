local M = {}

local root_markers = { "mvnw", "gradlew", "pom.xml", "build.gradle", ".git" }

local function find_root(startpath)
  local root_file = vim.fs.find(root_markers, { upward = true, path = startpath })[1]
  if root_file then
    return vim.fs.dirname(root_file)
  end
end

local function lombok_path()
  local candidates = {
    vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar"),
    vim.fn.expand("~/lombok.jar"),
  }
  for _, path in ipairs(candidates) do
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end
end

function M.setup()
  local ok, jdtls = pcall(require, "jdtls")
  if not ok then
    vim.notify("nvim-jdtls is not available", vim.log.levels.WARN)
    return
  end

  local group = vim.api.nvim_create_augroup("CoffebarJdtls", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "java",
    callback = function(args)
      if vim.fn.executable("jdtls") ~= 1 then
        vim.notify("`jdtls` executable not found in PATH", vim.log.levels.ERROR)
        return
      end

      local bufname = vim.api.nvim_buf_get_name(args.buf)
      local root_dir = find_root(bufname ~= "" and bufname or vim.loop.cwd())
      if not root_dir then
        vim.notify("Could not find Java project root (pom.xml/gradlew/mvnw)", vim.log.levels.WARN)
        return
      end

      local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fs.basename(root_dir)
      vim.fn.mkdir(workspace_dir, "p")
      local cmd = { "jdtls", "-data", workspace_dir }
      local lombok = lombok_path()
      if lombok then
        table.insert(cmd, 2, "--jvm-arg=-javaagent:" .. lombok)
      end

      local config = {
        cmd = cmd,
        root_dir = root_dir,
        settings = {
          java = {
            format = { enabled = true },
            configuration = { updateBuildConfiguration = "interactive" },
            maven = { downloadSources = true },
            signatureHelp = { enabled = true },
            completion = {
              favoriteStaticMembers = {
                "org.junit.jupiter.api.Assertions.*",
                "org.mockito.Mockito.*",
                "java.util.Objects.requireNonNull",
              },
            },
          },
        },
        init_options = { bundles = {} },
      }

      jdtls.start_or_attach(config)

      local has_dap = pcall(require, "dap")
      if has_dap and jdtls.setup_dap then
        jdtls.setup_dap({ hotcodereplace = "auto" })
      end
      local ok_setup, jdt_setup = pcall(require, "jdtls.setup")
      if ok_setup and jdt_setup.add_commands then
        jdt_setup.add_commands()
      end
    end,
  })
end

return M

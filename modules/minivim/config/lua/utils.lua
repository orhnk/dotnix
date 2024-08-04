return {
  mapping_utils = {
    map = function(modes, mapping_list, opts)
      for key, value in pairs(mapping_list) do
        local cmd, desc

        if type(value) == "table" then
          cmd = value[1]
          desc = value[2]
        else
          cmd = value
        end

        local keymap_opts = { desc = desc }
        if opts then
          for opt_key, opt_value in pairs(opts) do
            keymap_opts[opt_key] = opt_value
          end
        end

        vim.keymap.set(modes, key, cmd, keymap_opts)
      end
    end,

    del = function(modes, mapping_list)
      for _, value in pairs(mapping_list) do
        vim.keymap.del(modes, value)
      end
    end,
  },
}

{...}: {
  programs.git = {
    enable = true;

    signing = {
      key = "C17A78D5551E2126ED7D60EFB51E5F7876988A66";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Douglas Lobo";
        email = "douglascnlobo@icloud.com";
      };

      init.defaultBranch = "main";
      color.ui = "auto";
      core = {
        bare = false;
        filemode = true;
        logallrefsupdates = true;
        autocrlf = "input";
      };
      merge.tool = "nvimdiff";
      diff.tool = "nvimdiff";
      difftool.prompt = false;
      rebase.autostash = true;

      alias = {
        l = "log --oneline --graph --decorate";
        b = "branch";
        ba = "branch -a";
        wt = "worktree";
        sw = "switch";
        co = "checkout";
        ci = "commit";
        amend = "commit --all --amend --no-edit";
        st = "status -s";
        pr = "pull --rebase";
        m = "merge";
        sta = "status";
        rh = "reset HEAD";
        aa = "add --all";
        release = "tag -a \"$1\" -m \"release $2\"";
      };
    };
  };
}

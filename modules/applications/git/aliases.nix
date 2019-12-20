let
  sh = text: ''!sh -c "${text}"'';
  git = text: ''"!git ${text}"'';
  f = text: ''"!f(){ ${text} };f"'';
in {
  # Unstage all changes
  unstage = "reset HEAD --";

  # Ammend to the last commit
  amend = "commit --amend -C HEAD";

  # Delete all branches that were merged into master
  brd = sh
    "git checkout master && git branch -a --merged | grep -v '*' | xargs -n 1 git branch -d";

  # Delete all branches that were merged into the current branch
  brdhere =
    sh "git branch -a --merged | grep -v '\\\\*' | xargs -n 1 git branch -d";

  # List branches sorted by last modified
  b = git
    "for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'";

  # Test merge for conflicts before merging
  mergetest = f ''
    git merge --no-commit --no-ff "$1"; git merge --abort; echo "Merge aborted";'';

  # Change author of last commit
  cauthor = "commit --ammend --no-edit --author";

  # Get description of current repo
  description = git
    ''config --get "branch.$(git rev-parse --abbrev-ref HEAD).description"'';

  # Show authors
  authors = ''
    "!f() { git log --no-merges --pretty='format:%<(26)%an <%ae>' --author "$*" | sort | uniq# }# f"'';

  # Fix .gitignore
  fixgitignore = git
    ''rm -r --cached . && git add . && git commit -m "Just a .gitignore fix"'';

  # Check if any file in repo has whitespace errors
  check-whitespace =
    git "diff-tree --check $(git hash-object -t tree /dev/null) HEAD";

  # View history
  hist = "log --all --stat --graph";

  a = "add";
  ap = "add --patch";
  bi = "bisect";
  bl = "blame";
  c = "commit";
  ca = "commit --all";
  cm = "commit --message";
  caa = "commit --ammend";
  cam = "commit --all --message";
  cl = "clone";
  co = "checkout";
  com = "checkout master";
  col = "checkout @{-1}";
  cob = "checkout -b";
  cp = "cherry-pick";
  d = "diff --color --no-ext-diff";
  dc = "!git d --cached";
  dcs = "!git d --cached --stat";
  des = "describe --contains";
  ds = "!git d --stat";
  dt = "difftool";
  dw = "!git d --word-diff=color";
  f = "fetch";
  g = "grep";
  h = "help";
  l =
    "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
  lfp = "!git l --first-parent";
  ln = "!git l @{1}..";
  lso = "ls-files --others --exclude-standard";
  lsr = "ls-remote";
  s = "status -sb";
  sh = "show";
  shs = "show --stat";
  st = "stash";
  stl = "stash list";
  sts = "stash show -p";
  t = "tag";
  tr = "trail";
  unmerged = "branch -a --no-merged master";
  wt = "worktree";
}

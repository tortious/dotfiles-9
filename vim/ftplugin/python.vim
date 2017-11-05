python << EOF
import os
import sys

if 'CONDA_PREFIX' not in os.environ:
  sys.exit(0)

prefix = os.environ['CONDA_PREFIX']
path = os.path.join(prefix, 'lib/python2.7/site-packages')
if not path in sys.path:
  sys.path.insert(0, path)

for dirpath, dirnames, fnames in os.walk(path):
  for fname in fnames:
    if fname != 'easy-install.pth':
      continue
    fname = os.path.join(dirpath, fname)
    for line in open(fname):
      path = line.strip()
      if os.path.exists(path):
        sys.path.insert(0, path)

EOF

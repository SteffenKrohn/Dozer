Place the credential file in the same directory as the pull_stats.py.
Then install firestore-admin and run the pull_stats.py within your console:
```sh
$ pip install --upgrade firebase-admin
$ py pull_stats.py
```

The datasets are ordered chronologically descendant.

**Attention**: limit is set to not exceed the free plan

_testet with python 3.7_
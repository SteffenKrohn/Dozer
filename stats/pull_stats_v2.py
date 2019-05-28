import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import csv

# init service account
cred = credentials.Certificate('dozer-credential.json')
firebase_admin.initialize_app(cred)

# connect with db
db = firestore.client()

# init visits and scores collection ref
visits_ref = db.collection(u'visits').order_by(u'timestamp', direction=firestore.Query.DESCENDING).limit(5000)
scores_ref = db.collection(u'scores').order_by(u'timestamp', direction=firestore.Query.DESCENDING).limit(5000)

# get documents
visit_docs = visits_ref.get()
scores_docs = scores_ref.get()

# prepare csv meta
visits_columns = ["userId", "reachedLevel", "viewHeight", "viewWidth", "timestamp", "isGyroAvailable", "isFullscreen"]
scores_columns = ["userId", "reachedLevel", "timestamp", "level", "score", "tries", "won", "abort", "isGyroAvailable"]

visits_file = "visits_v2.csv"
scores_file = "scores.csv"

# write to csv files
with open(visits_file, 'w') as csv_file:
    writer = csv.DictWriter(csv_file, fieldnames=visits_columns)
    writer.writeheader()
    for doc in visit_docs:
        d = doc.to_dict()
        if 'isFullscreen' not in d:
            isFullscreen = ""
        else:
            isFullscreen = str(d["isFullscreen"])
        line = str(d["userId"]) + "," + str(d["reachedLevel"]) + "," + str(d["viewHeight"]) + "," + str(d["viewWidth"])\
               + "," + str(d["timestamp"]) + "," + str(d["isGyroAvailable"]) + "," + isFullscreen + "\n"
        csv_file.write(line)

with open(scores_file, 'w') as csv_file:
    writer = csv.DictWriter(csv_file, fieldnames=scores_columns)
    writer.writeheader()
    for doc in scores_docs:
        d = doc.to_dict()
        if 'tries' not in d:
            tries = ""
        else:
            tries = str(d["tries"])
        if 'abort' not in d:
            abort = ""
        else:
            abort = str(d["abort"])
        line = str(d["userId"]) + "," + str(d["reachedLevel"]) + "," + str(d["timestamp"]) + "," + str(d["level"])\
               + "," + str(d["score"]) + "," + tries + "," + str(d["isGyroAvailable"]) + "," + abort + "," + str(d["isGyroAvailable"]) + "\n"
        csv_file.write(line)

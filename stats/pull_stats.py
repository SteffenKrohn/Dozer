import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import csv

# init service account
cred = credentials.Certificate('dozer-credential.json')
firebase_admin.initialize_app(cred)

# connect with db
db = firestore.client()

# init visits and levelstarts collection ref
visits_ref = db.collection(u'visits').order_by(u'timestamp', direction=firestore.Query.DESCENDING).limit(100)
levelstarts_ref = db.collection(u'levelstarts').order_by(u'timestamp', direction=firestore.Query.DESCENDING).limit(500)

# get documents
visit_docs = visits_ref.get()
levelstarts_docs = levelstarts_ref.get()

# prepare csv meta
visits_columns = ["userId", "reachedLevel", "viewHeight", "viewWidth", "timestamp", "isGyroAvailable"]
levelstarts_columns = ["userId", "startetLevel", "reachedLevel", "timestamp", "isGyroAvailable"]

visits_file = "visits.csv"
levelstarts_file = "levelstarts.csv"

# write to csv files
with open(visits_file, 'w') as csv_file:
    writer = csv.DictWriter(csv_file, fieldnames=visits_columns)
    writer.writeheader()
    for doc in visit_docs:
        d = doc.to_dict()
        line = str(d["userId"]) + "," + str(d["reachedLevel"]) + "," + str(d["viewHeight"]) + "," + str(d["viewWidth"]) + "," + str(d["timestamp"]) + "," + str(d["isGyroAvailable"]) + "\n"
        csv_file.write(line)

with open(levelstarts_file, 'w') as csv_file:
    writer = csv.DictWriter(csv_file, fieldnames=levelstarts_columns)
    writer.writeheader()
    for doc in levelstarts_docs:
        d = doc.to_dict()
        line = str(d["userId"]) + "," + str(d["startetLevel"]) + "," + str(d["reachedLevel"]) + "," + str(d["timestamp"]) + "," + str(d["isGyroAvailable"]) + "\n"
        csv_file.write(line)

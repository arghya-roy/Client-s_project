## Link GA4 with BigQuery -
- Have to enable BigQuery api from console or using cli.
- Come to GA4.
- Click on admin.
- Click on BigQuery linking.
- Click on link.
- Select your GCP BigQuery project to which you want to link GA4 with BigQuery.
- Select your BigQuery data location.
- By default all the data streams are selected, you can modify them if you want.
- Select your frequency - Daily / Streaming / Both.
- Click on submit.
- Wait upto 24 hours Then you can see GA4 data inside BigQuery and dataset will be created automatically.
### For our cases we successfully imported GA4 data to to BigQuery after following previous steps. But as per some google documentations, wehave to create a service accout. So after following the previous steps if you are unable to import data to BigQuery then follow below steps.

- At first follow all previous steps.
- Then search by Enabled APIs and Services, and click on that.
- There you will get a search bar, inside there search by BigQuery api and clock on it.
- Click on manage ( In one of our previous step we enabled BigQuery api, So we will get option to manage ).
- Click on credentials, after that click on create on create credentials.
- select service account option.
- give the service account name `firebase-measurement@system.gserviceaccount.com`
- Click on create and click on done.

### Now wait upto 24 hours then you can see your ga4 data inside BigQuery.

---

## Link BigQuery to Data Studio - 
- enable Data Studio api from gcp console or using CLI.
- Open `https://datastudio.google.com/` and sign in.
- From Data Studio console click on Blank Report.
- As a Data source select BigQuery.
- If you are not Authorize, Then you will get a option to authorize yourselt. Then click “Authorize”.
- From left panel click on my projects, then select your project where your BigQuery data are stored, Then elect the data set where your bigquery data are stored, after that select events.
- Now you BigQuery is linked with Data Studio.
- You can make your dashboard and matrics as per your requirement from Data Studio.


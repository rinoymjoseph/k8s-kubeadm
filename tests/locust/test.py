from locust import HttpUser, task

class HelloWorldUser(HttpUser):
    @task
    def hello_world(self):
        self.client.get("/asset/GetAssetData/4de1208e-d1b7-46a1-9743-8f2b39c3ad39")
        self.client.get("/asset/GetAssetDataSeq/4de1208e-d1b7-46a1-9743-8f2b39c3ad39")
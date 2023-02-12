FROM ubuntu:20.04
COPY . /app/backend
WORKDIR /app/backend
RUN apt-get update && apt-get install python3-pip -y
RUN pip3 install --upgrade pip && pip3 install --upgrade setuptools
RUN pip3 install -r requirements.txt
CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8000" ]
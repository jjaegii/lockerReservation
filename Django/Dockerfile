FROM ubuntu:20.04
COPY . /app/backend
WORKDIR /app/backend
RUN apt-get update
RUN apt-get install python3-pip -y
RUN pip3 install --upgrade pip && pip3 install --upgrade setuptools
RUN pip3 install -r requirements.txt
RUN python3 manage.py makemigrations && python3 manage.py migrate
CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8000" ]

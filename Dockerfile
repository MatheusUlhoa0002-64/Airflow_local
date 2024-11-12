FROM apache/airflow:2.10.3-python3.11

COPY requirements.txt /requirements.txt
USER root
RUN apt-get update && apt-get install -y python3-opencv 

RUN apt-get install -y wget
RUN apt-get update && wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
RUN apt-get install ./google-chrome-stable_current_amd64.deb -y



RUN apt-get update && \
    apt-get install -y locales && \
    sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales

USER airflow
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r /requirements.txt
RUN playwright install

FROM --platform=$TARGETPLATFORM python:3.10-alpine

LABEL maintainer="David Hong <gdavid0510@gmail.com>"
LABEL version="0.1"

# Environment Variables
ENV TZ=Asia/Seoul
ENV USER_UID=1000
ENV USER_GID=1000
ENV PYTHONUNBUFFERED=1
ENV PYTHONIOENCODING=utf-8
ENV NID_AUT="CHANGEME"
ENV NID_SES="CHANGEME"
ENV STREAMER_ID="CHANGEME"

# Set the working directory
WORKDIR /app
# Copy files
COPY . .

# chat.log file should be saved inside a volume
# VOLUME /log
# RUN	touch /log/chat.log \
# &&	ln -s /log/chat.log /app/chat.log

# Install the requirements and set timezone
RUN	pip install -r requirements.txt \
&&	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Run the application
CMD ["python", "run.py", "--streamer_id", "$STREAMER_ID"]

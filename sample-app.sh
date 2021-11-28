#!/bin/bash

mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

cp api_app.py tempdir/.
cp network_equipment.json tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

echo "FROM python" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "COPY  ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY  ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY  api_app.py /home/myapp/" >> tempdir/Dockerfile
echo "COPY  network_equipment.json /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "CMD python /home/myapp/api_app.py" >> tempdir/Dockerfile

cd tempdir
docker build -t apiapp .
docker run -t -d -p 5050:5050 --name apiapprunning --network host apiapp
docker ps -a 

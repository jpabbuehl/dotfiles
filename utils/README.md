# Evaluating dot files in vanilla OS system

TBD
docker build -t dot_test:latest .
docker build --ssh default -t dot_test:latest .
docker build --build-arg caching=1 --ssh default -t dot_test:latest .

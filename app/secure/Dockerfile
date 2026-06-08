FROM python:3.12-alpine

RUN addgroup -g 10001 -S app && adduser -u 10001 -S app -G app

WORKDIR /app
COPY --chown=10001:10001 app.py .

USER 10001:10001

EXPOSE 8080
CMD ["python", "app.py"]

# FROM hasura/graphql-engine:v2.3.1
FROM hasura/graphql-engine:v2.3.1.cli-migrations-v3

# Dockerfileに渡す変数
ARG DB_USER
ARG DB_PASSWORD
ARG DB_HOST
ARG DB_PORT
ARG DB_DATABASE
ARG HASURA_ADMIN_SECRET
ARG HASURA_JWT_SECRET

# # migration, metadataをコピー
COPY ./hasura/migrations /hasura_migrations
COPY ./hasura/metadata /hasura_metadata

# Hasura環境変数値設定
ENV HASURA_GRAPHQL_DATABASE_URL="postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"
ENV HASURA_GRAPHQL_ENABLE_CONSOLE="true"
ENV HASURA_GRAPHQL_UNAUTHORIZED_ROLE="anonymous"
ENV HASURA_GRAPHQL_ADMIN_SECRET="${HASURA_ADMIN_SECRET}"
ENV HASURA_GRAPHQL_JWT_SECRET="${HASURA_JWT_SECRET}"
ENV HASURA_GRAPHQL_MIGRATIONS_DIR=/hasura_migrations
ENV HASURA_GRAPHQL_METADATA_DIR=/hasura_metadata

# 通信用ポート開放
EXPOSE 8080

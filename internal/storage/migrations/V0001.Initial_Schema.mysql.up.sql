CREATE TABLE IF NOT EXISTS authentication_logs (
    id INTEGER AUTO_INCREMENT,
    time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    successful BOOLEAN NOT NULL,
    banned BOOLEAN NOT NULL DEFAULT FALSE,
    username VARCHAR(100) NOT NULL,
    auth_type VARCHAR(5) NOT NULL DEFAULT '1FA',
    remote_ip VARCHAR(47) NULL DEFAULT NULL,
    request_uri TEXT NOT NULL,
    request_method VARCHAR(8) NOT NULL DEFAULT '',
    PRIMARY KEY (id)
);

CREATE INDEX authentication_logs_username_idx ON authentication_logs (time, username, auth_type);
CREATE INDEX authentication_logs_remote_ip_idx ON authentication_logs (time, remote_ip, auth_type);

CREATE TABLE IF NOT EXISTS identity_verification (
    id INTEGER AUTO_INCREMENT,
    jti CHAR(36),
    iat TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    exp TIMESTAMP NOT NULL,
    used TIMESTAMP NULL DEFAULT NULL,
    username VARCHAR(100) NOT NULL,
    action VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (jti)
);

CREATE TABLE IF NOT EXISTS totp_configurations (
    id INTEGER AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    issuer VARCHAR(100),
    algorithm VARCHAR(6) NOT NULL DEFAULT 'SHA1',
    digits INTEGER NOT NULL DEFAULT 6,
    period INTEGER NOT NULL DEFAULT 30,
    secret BLOB NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (username)
);

CREATE TABLE IF NOT EXISTS u2f_devices (
    id INTEGER AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    description VARCHAR(30) NOT NULL DEFAULT 'Primary',
    key_handle BLOB NOT NULL,
    public_key BLOB NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (username, description)
);

CREATE TABLE IF NOT EXISTS duo_devices (
    id INTEGER AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    device VARCHAR(32) NOT NULL,
    method VARCHAR(16) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (username)
);

CREATE TABLE IF NOT EXISTS user_preferences (
    id INTEGER AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    second_factor_method VARCHAR(11) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (username)
);

CREATE TABLE IF NOT EXISTS migrations (
    id INTEGER AUTO_INCREMENT,
    applied TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    version_before INTEGER NULL DEFAULT NULL,
    version_after INTEGER NOT NULL,
    application_version VARCHAR(128) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS encryption (
  id INTEGER AUTO_INCREMENT,
  name VARCHAR(100),
  value BLOB NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY (name)
);

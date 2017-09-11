#!/bin/bash
set -e

sed -ri "s|#include_dir = 'conf.d'|include_dir = '/var/lib/postgresql/conf.d' |g" /var/lib/postgresql/data/postgresql.conf
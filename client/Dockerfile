FROM alpine

###############################################################################
#                                UPDATE OS
###############################################################################

RUN set -ex \
 && apk update -q --progress \
 && apk upgrade -q --progress

###############################################################################
#                            INSTALL DEPENDENCIES
###############################################################################

RUN set -ex \
 && apk add --no-cache -q --progress \
      ca-certificates \
      openssl \
      curl \
      bash \
      vim

###############################################################################
#                                    START
###############################################################################

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD [ "/entrypoint.sh" ]

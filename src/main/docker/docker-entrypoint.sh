#!/bin/bash

DIR=/docker-entrypoint.d

if [[ -d "$DIR" ]]
then
  for SCRIPT in ${DIR}/*; do
    echo "> $(tput bold)Executing ${SCRIPT}$(tput sgr0)"
    . "$SCRIPT"
  done
fi

echo "$(tput bold)> Starting CMD:$(tput sgr0) $@"
echo "$(tput dim)> exec $(eval eval echo $@)$(tput sgr0)"

# first 'eval' expands variables (like $JAVA_OPTS) in $@
# second 'eval' flattens arguments, so that $JAVA_OPTS expanded into is not seen as a single argument (DOCKER-136)
# which enables us to use exec-form with $JAVA_OPTS support:
# -> `CMD ["java", "$JAVA_OPTS", "-jar", "foo.jar"]`
eval eval exec $@
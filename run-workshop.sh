#!/bin/bash -e

PV='pv -qL'

command()
{
  speed=$2
  [ -z "$speed" ] && speed=10

  echo "> $1" | $PV $speed
  sh -c "$1"
  echo | $PV $speed
}

out()
{
  speed=$2
  [ -z "$speed" ] && speed=10

  echo "$1" | $PV $speed
  echo | $PV $speed
}

cleanup()
{
  clear
  command 'make stop'
}

record()
{
  clear
  out 'Record this workshop'
  command "asciinema rec -t 'Cloud Native Security Workshop - Container Image Encryption'  coco_container_image_encryption.cast -c '$0 play'"
}

screen1()
{
  clear
  out "This workshop demonstrates container image encryption using Confidential Containers Attestation Agent"
  out "You can either run it yourself or 'asciinema play' offline."
  out "Let's get started!"
}

screen2()
{
  clear
  out "1. Setup the environment: start a 'keyprovider' gRPC service"
  command "make setup"
}

screen3()
{
  clear
  out "2. Run skopeo to encrypt a single layer image using the 'keyprovider' to wrap the key"
  command 'make encrypt'
  sleep 10
}

screen4()
{
  clear
  out "3. Check the image encryption results"
  command "make check"
  out "That's it!"
  sleep 5
}

if [ "$1" == 'play' ] ; then
  if [ -n "$2" ] ; then
    screen$2
  else
    for n in $(seq 4) ; do screen$n ; sleep 3; done
  fi
elif [ "$1" == 'cleanup' ] ; then
  cleanup
elif [ "$1" == 'record' ] ; then
  record
else
   echo "Usage: $0 [--help|help|-h] | [play [<screen number>]] | [cleanup] | [record]"
fi

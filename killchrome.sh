#! /bin/sh

ps aux | grep "Chrome" | awk '{print $2}' | xargs kill

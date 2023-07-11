#!/bin/bash

if [ ! -d "$HOME/data" ]; then
	mkdir "$HOME/data";
	mkdir "$HOME/data/mariadb";
	mkdir "$HOME/data/wordpress";
fi
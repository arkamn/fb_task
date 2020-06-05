# FUNBOX qualification task

**TODO: Add documentation and tests**

## Requirements
- curl 7 or newer
- Elixir v1.10
- Redis 6.0

## Installation
From GIT repo.
Open a terminal window and take the command:
```
	$ git clone https://github.com/arkamn/fb_task.git
	$ cd fb_task
	$ iex -S mix
```
## How to use
1. Open the second terminal window and call ```curl --version```. Check Elixir and Redis similarly.

HINT: if your systen doesn't contain the curl util and so on please find documentation for your OS and install.

2. Let's creat array of links throught HTTP POST request:

```$ curl -H 'Content-Type: application/x-www-form-urlencoded' -XPOST http://localhost:8999/visited_links -d '{"links": ["https://ya.ru","https://ya.ru?q=123","funbox.ru","https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor"]}'```

After that you take a response like:
```
	HTTP/1.1 201 Created
	Content-Type: application/json
	Content-Length: 50

	Links created and saved in DB from 07:12:36.036951
```

HINT: also you can crea array of links from a file:

```$ curl -X POST -H "Content-Type: application/json" -d @[..DIR..]/fb_task/tmp/links.json http://localhost:8999/visited_links```

but in this case you need to change [..DIR..] to your absolute path.

3. In next step you need to take UTC time format and then convert to timestamp for preparation of HTTP GET request.
Example:
UTC format of time: 07:12:36.036951
GET request format: 71236036957
But also you need end timestamp of request for generate range-like HTTP GET request for range database response. Simple way of this just add a few of seconds to request temestamp - 71238036957 (38 seconds)
Put next command to termaial:

```$ curl -XGET -H 'Content-Type: application/json' http://localhost:8999/visited_domains -d '?from=71236036957&to=71236036957'```

And you shell be see the response like:

```
	HTTP/1.1 200 OK
	Content-Type: application/json
	Content-Length: 61

	{"domains":["ya.ru","ya.ru","funbox.ru","stackoverflow.com"]}
```

HINT: if you see {"domains":[]} in response message please shall see instruction at step 3 and enter timestamp-range correctly.

Thank's for reading!
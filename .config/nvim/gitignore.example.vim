" # vim-startify
let g:startify_bookmarks = ['~/Documents', '~/Music']

" # vim-dadbod
let db = {
    \"name": "dbms Admin",
    \"url": "postgresql://admin:0000@localhost:8080/dbms"
\}
call add(g:dadbods, db)

let db = {
    \"name": "flask-group-chat",
    \"url": "sqlite:instance/flask_group_chat.sqlite"
\}
call add(g:dadbods, db)

"   if g:db and b:db is set up -- b:db will be used.
"   so g:db would serve as a default database (first in the list)
let g:db = g:dadbods[0].url

" Vim-dadbod  sql connection strings
" Usage
"   :DBList
"   :DBSelect db_id
let g:dadbods = []

let db = {
		\"name": "dbms Admin",
		\"url": "postgresql://admin:0000@localhost:8080/dbms"
		\}
call add(g:dadbods, db)

let db = {
		\"name": "TodoApi admin",
		\"url": "postgresql://postgres:0000@localhost/postgres"
		\}
call add(g:dadbods, db)

let db = {
		\"name": "webrtc_customer_service Admin",
		\"url": "postgresql://postgres:1234@localhost/webrtc_customer_service"
		\}
call add(g:dadbods, db)

let db = {
		\"name": "flask-group-chat",
		\"url": "sqlite:instance/flask_group_chat.sqlite"
		\}
call add(g:dadbods, db)

let db = {
		\"name": "",
		\"url": ""
		\}
call add(g:dadbods, db)

let db = {
		\"name": "songs Admin",
		\"url": "sqlite:songs.db"
		\}
call add(g:dadbods, db)



" if g:db and b:db is set up -- b:db will be used.
" so g:db would serve as a default database (first in the list)
let g:db = g:dadbods[0].url

command! -nargs=1 DBSelect :call DBSelected(<f-args>)
command! DBList :call DBListed()

function! DBListed()
    echo "ID | DB Name | URL"
    echo "------------------"
    let i = 0
    for line in g:dadbods
        echo i'|'line.name "\t|" line.url
        let i += 1
    endfor
endfunction

function! DBSelected(dadbodIndex)
    let b:db = g:dadbods[a:dadbodIndex].url
    echomsg 'DB "' . g:dadbods[a:dadbodIndex].name . '" is selected.'
endfunction

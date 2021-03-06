<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/_include/Head.jsp"%>
<title>ADMIN CLI</title>
<style type="text/css">
html,body,input, .rb-console .out {
    background-color: #222;
    color: #f1f1f1;
    font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
    line-height: 1.5;
    font-size: 12px;
}
.rb-console {
    padding: 20px;
}
.rb-console input {
    width: 100%;
    padding: 6px 2px;
    border: 0 none;
    appearance: none;
    -webkit-appearance: none;
    outline: none;
    border-bottom: 1px solid rgba(255,255,255,0.2);
}
.rb-console .out {
    margin-top: 20px;
}
.rb-console .out>div::before {
    content: '> ';
}
.rb-console .out>div.o::before {
    content: '$ ';
}
</style>
</head>
<body>
<div class="rb-console">
    <div class="in">
        <input type="text" placeholder="> enter command ..." />
    </div>
    <div class="out"></div>
</div>
<%@ include file="/_include/Foot.jsp"%>
<script type="text/babel">
$(document).ready(() => {
    const $in = $('.in>input').keydown((event) => {
        if (event.which == 13 && $in.val()) {
            const c = $in.val().trim()
            $in.val('')
            if (c === 'clean') {
                $('.out').empty()
                return
            }

            cprint(c)
            $.post('/admin/cli/exec', (c), (o) => {
                if (o) cprint(o, true)
            })
        }
    })
    $in.focus()
})
const cprint = function (c, o) {
    $('.out').prepend('<div class="' + (o ? 'o' : '') + '">' + c + '</div>')
}
</script>
</body>
</html>
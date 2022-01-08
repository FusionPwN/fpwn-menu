document.onkeyup = function(data) {
    // If Key == ESC -> Close Phone
    if (data.key == 'Escape') {
        $.post('https://fpwn-menu/cancelMenu', JSON.stringify({}));
    }
}

var menu_id = false

$(function() {
    $.post('https://fpwn-menu/nuiready', JSON.stringify({}))

    window.addEventListener('message', function(event) {
        var item = event.data;
        switch (item.action) {
            case 'show-menu':
                ShowMenu(item.id, item.struct)
                break;
            case 'hide-menu':
                HideMenu()
                break;
        }
    })

    $(document).on('click', '.clickable', function(e) {
        let index = $(this).data('index')
        let val = $(this).data('value') || false
        if (!index) return

        $.post('https://fpwn-menu/clickMenuItem', JSON.stringify({
            index: index,
            menuid: menu_id,
            value: val
        }));
    })
})

function ShowMenu(id, struct) {
    menu_id = id
    $('.menu-ui').empty()
    $.each(struct, function(index, item) {
        let elem_content = ``

        if (item.type == 'title') {
            elem_content = `
                <span>${item.text}</span>
            `
        }
        else if (item.type == 'back') {
            elem_content = `
                <span><i class="fas fa-chevron-left"></i></span>
                <span>${item.text}</span>
            `
        }
        else if (item.type == 'button') {
            elem_content = `
                <span>${item.text}</span>
                ${item.description ? `<span class="description">${item.description}</span>` : ``}
            `
        }
        else if (item.type == 'button-sub') {
            elem_content = `
                <div class="menu-button-sub-desc">
                    <span>${item.text}</span>
                    <span class="description">${item.description || ''}</span>
                </div>
                <span><i class="fas fa-chevron-right"></i></span>
            `
        }

        let elem = `
            <div class="menu-item menu-${item.type} ${item.clickable ? 'clickable' : ''}" data-index="${index + 1}" data-value="${item.value}">
                ${elem_content}
            </div>
        `
        $('.menu-ui').append(elem)
    })

    $('.menu-ui').css('display', 'flex')
    animateCSS($('.menu-ui'), 'fadeInRight').then((message) => {

    })
}

function HideMenu() {
    animateCSS($('.menu-ui'), 'fadeOutRight').then((message) => {
        $('.menu-ui').hide(0, function() {
            $('.menu-ui').empty()
        }) 
    })
}

const animateCSS = (element, animation, prefix = 'animate__') =>
    // We create a Promise and return it
    new Promise((resolve, reject) => {
        const animationName = `${prefix}${animation}`
        const node = element
        
        node.addClass(`${prefix}animated`)
        node.addClass(`${animationName}`)
        
        // When the animation ends, we clean the classes and resolve the Promise
        function handleAnimationEnd(event) {
            event.stopPropagation()
            node.removeClass(`${prefix}animated`)
            node.removeClass(`${animationName}`)
            resolve('Animation ended')
        }
        
        node.on('animationend', handleAnimationEnd)
    }
)
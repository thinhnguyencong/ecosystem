export const FILE_TYPE_CAN_BE_PREVIEWED = [
    'application/pdf', 
    'application/vnd.openxmlformats-officedocument.presentationml.presentation', 
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'text/javascript',
    'text/html',
    'text/css',
    'audio/mpeg',
    'video/mp4',
    'image/png',
    'text/plain',
    'application/json',
    'image/jpeg',
    'text/csv',
    'sql'
]

export const getClassFileType = (type) => {
    switch(type) {
        case 'application/pdf': return "mdi mdi-file-pdf-box text-danger"
        case 'application/vnd.ms-powerpoint': return "mdi mdi-file-powerpoint text-danger"
        case 'application/vnd.openxmlformats-officedocument.presentationml.presentation': return "mdi mdi-microsoft-powerpoint text-danger"
        case 'application/msword': return "mdi mdi-file-word text-primary"
        case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document': return "mdi mdi-microsoft-word text-primary"
        case 'application/vnd.ms-excel': return "mdi mdi-file-excel text-success"
        case 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': return "mdi mdi-microsoft-excel text-success"
        case 'text/javascript': return "mdi mdi-language-javascript text-warning"
        case 'text/x-java-source': return "mdi mdi-language-java text-danger"
        case 'text/html': return "mdi mdi-language-html5 text-warning"
        case 'text/css': return "mdi mdi-language-css3 text-primary"
        case 'audio/mpeg': return "mdi mdi-file-music-outline text-primary"
        case 'video/mp4': return "mdi mdi-file-video-outline text-primary"
        case 'image/png': return "mdi mdi-file-png-box text-warning"
        case 'text/plain': return "mdi mdi-note-text-outline text-secondary"
        case 'application/json': return "mdi mdi-code-json text-warning"
        case 'image/jpeg': return "mdi mdi-image text-primary"
        case 'text/csv': return "mdi mdi-comma-box-outline text-secondary"
        case 'application/zip': return "mdi mdi-zip-box-outline text-secondary"
        case 'application/vnd.rar': return "mdi mdi-zip-box-outline text-secondary"
        case 'application/x-zip-compressed': return "mdi mdi-zip-box-outline text-secondary"
        case 'application/epub+zip': return "mdi mdi-book-open text-primary"
        case 'sql': return "mdi mdi-database text-secondary"
        default: return "mdi mdi-file text-secondary"
    }
}

export const getLayoutOfPage = (publicAddress, route) => {
    const DEFAULT_LAYOUT = "grid"
    const LAYOUT_PAGE = ["Home", "My Folder", "Shared With Me", "Directory"]
    let userConfigs = localStorage.getItem("configs")
    userConfigs=JSON.parse(userConfigs)

    if (!userConfigs) {
        userConfigs = initUserConfig(publicAddress)
        localStorage.setItem("configs", JSON.stringify(userConfigs))
    }
    if(!userConfigs[publicAddress]) {
        let newUser = initUserConfig(publicAddress)
        userConfigs = {
            ...userConfigs,
            ...newUser
        }
        localStorage.setItem("configs", JSON.stringify(userConfigs))
    }
    if(!LAYOUT_PAGE.includes(route.name)) {
        return userConfigs?.[publicAddress]?.["layout"]?.[route.matched[0].path] ? userConfigs[publicAddress]["layout"][route.matched[0].path] : "grid"
    }
    if (userConfigs[publicAddress]["layout"][route.path]){
       return userConfigs[publicAddress]["layout"][route.path]
    }
    userConfigs[publicAddress]["layout"][route.path] = DEFAULT_LAYOUT
    localStorage.setItem("configs", JSON.stringify(userConfigs))
    return DEFAULT_LAYOUT
}

export const setLayoutOfPage = (publicAddress, route, layout) => {
    let userConfigs = localStorage.getItem("configs")
    userConfigs=JSON.parse(userConfigs)
    userConfigs[publicAddress]["layout"][route.path] = layout
    localStorage.setItem("configs", JSON.stringify(userConfigs))
}
const initUserConfig = (publicAddress) => {
    const initConfig = {
        [publicAddress]: {
            "layout": {
                "/": "grid",
                "/my-folder": "grid"
            }
        }
    }
    return initConfig
}
export const getClassFileType = (type) => {
    switch(type) {
        case 'application/pdf': return "mdi mdi-file-pdf-box text-danger"
        case 'application/vnd.ms-powerpoint': return "mdi mdi-microsoft-powerpoint text-danger"
        case 'application/vnd.openxmlformats-officedocument.presentationml.presentation': return "mdi mdi-microsoft-powerpoint text-danger"
        case 'application/msword': return "mdi mdi-microsoft-word text-primary"
        case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document': return "mdi mdi-microsoft-word text-primary"
        case 'application/vnd.ms-excel': return "mdi mdi-microsoft-excel text-success"
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
        default: return "mdi mdi-file text-secondary"
    }
}
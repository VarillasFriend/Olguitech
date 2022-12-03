// Don't allow uploading unsupported file types
window.addEventListener("trix-file-accept", (event) => {
    const acceptedTypes = ["image/jpeg", "image/png"];

    if (!acceptedTypes.includes(event.file.type)) {
        event.preventDefault();
        alert("Solo se soportan imagenes de tipo jpeg o png");
    }
});

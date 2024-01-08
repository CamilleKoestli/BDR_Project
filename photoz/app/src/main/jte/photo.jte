@import photoz.models.Photo

@param Photo photo

<a href="/photos/${photo.id}">
    <div class="mx-2 my-1 w-96 hover:bg-blue-100 p-1">
        <img src="images/${photo.path}" alt="" class="w-full">
        <p class="font-bold line-clamp-1 mt-1 mb-2">${photo.title}</p>
        <div class="flex text-gray-600">
            <p class="flex-1">${photo.pseudo}</p>
        </div>
    </div>
</a>
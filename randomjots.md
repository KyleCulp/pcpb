cases page: broadcast volume proudly

have 'postgresql-client-12' installed

motherboard:
  how to manage pci slots & compute against other hardware
  pci versions vary by cpu type
  sata slots and how its halved by m2 sometimes
  m2 support vary by cpu type


system fan headers against needed fan headers in list, ask if they need fan header extension

check this out later https://github.com/msaraiva/surface

what to do

1.) cache_map cpu add to form, lets see what it looks like in db
2.) tailwind css, get your own form layout going
3.) array inputs for cases
4.) reccomend inputs for certain forms (manufacturer, family, series, socket, etc), make it a live helper?
look into phx_deboucne
<nav class="<%= if @uri.path == "/", do: "transparent", else: "blue-background %>">

https://github.com/phoenixframework/phoenix_live_dashboard/blob/910059ea39d9399c399ccc6d6a2d5be56a2998b9/lib/phoenix/live_dashboard/components/table_component.ex#L218

  <div class="p-2 align-middle" id="motherboard_support" phx-hook="select" phx-update="ignore">
    <%= label f, :motherboard_support %>
    <%= multiple_select f, :motherboard_support, @motherboard_support_options, class: "motherboard_support-select" %>
    <%= error_tag f, :motherboard_support %>
  </div>
  <div class="p-2 align-middle" id="psu_support" phx-hook="selecttwo" phx-update="ignore">
    <%= label f, :psu_support %>
    <%= multiple_select f, :psu_support, @motherboard_support_options, class: "psu_support-select" %>
    <%= error_tag f, :psu_support %>
  </div>

memory has to check the capacity based on the quantity in box from seller


I don't really intend on supporting memory data specific to amd vs intel, as that seems to be a 1000/2000 series issue?
https://www.reddit.com/r/Amd/comments/ctgeiw/different_between_gskill_regular_ram_and_gskill/

return warnings in addition to errors for part compatability

product listings: include warranty

have product listings merge/overwrite the part on that page when viewing that specific page

individually sleeved black plastic coating https://images-na.ssl-images-amazon.com/images/I/51Mpxeo3RdL._AC_SL1001_.jpg

sleeved binded black plastic coating  https://c1.neweggimages.com/ProductImageCompressAll1280/A4M5_1_20200116596852916.jpg
might need to go back to cases and see if i have usb 3/2 headers from io to compare against mobo... i wonder if thisll be an issue with 99% of cases having at most one usb 3&usb2 header, while mobos have 3
some motherboards support dual sli & triple crossfire...

how will i query results from existing parts on the list to show valid parts only? I feel like piping query conditions with each specification / parts unique validation function could work, something like

```
def valid_cpus(list)
query
|>
```

figure out easy way to support ```2 x PCIe 3.0 x16 slots (support x16, x8/x8 modes)```
have list of enums for the different pcie arrangements, handle all of them in the check mobo module

product page = a page with images, links to retailers, maybe price analytics, and the part id of the core part of the product. I say this because the white case will be different than the default black case perhaps, there will be some inconsistencies but this overwrite default part specs seems to be the best solution to keep up with many different product variations of a part. Perhaps with gpu's, I could overwrite core nvidia/amd specs with the small shit other companies do?

Have a product page, it calls for a function to get that product from its id and preload the part referenced? But it'll have to be searched, not the easy ecto way.

user system with allowed parts to add / edit. sort it at parts.ex?

image select that merges @product.images and @uploads.photos.entries into one form, where you can drag the images around, and select one main one to display in larger size

products
  make manufacturers table, reference to different parts, have company logos saved
  products index shows most popular manufacturers w/ logo, then list of all different type of products


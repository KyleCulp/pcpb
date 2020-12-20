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


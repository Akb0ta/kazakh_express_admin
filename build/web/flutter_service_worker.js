'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "345f9ca1fdd8f4ef9ed20b5b629f4cf0",
"index.html": "187d77ca594bdecc8ec65d64096ef025",
"/": "187d77ca594bdecc8ec65d64096ef025",
"main.dart.js": "ae63071e4805a0d987ceddcba542a3e5",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "57cf3bb4ae3f95c63ca523cb5281e95a",
"assets/AssetManifest.json": "fb9a18912510ccbf8008591a4efa8585",
"assets/NOTICES": "3988fb5accdc8229b305296775c4153e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "6691916f58592b61a4333059964038c3",
"assets/fonts/MaterialIcons-Regular.otf": "61ae509f0940a8a4e8b8e5fdfbec70b9",
"assets/assets/images/document.png": "f633e6d175e4383ce24bffe009d83c46",
"assets/assets/images/kz-flag.png": "162487438b883339657585b919024588",
"assets/assets/images/login.png": "56bb5ca5e5d6b2f3656474c208d6fb88",
"assets/assets/images/kaspi.png": "67f4e450c566d37c04b26fd41d12ebeb",
"assets/assets/images/login_image.png": "f49b1ffbbe0dc05eedda0feefd635b13",
"assets/assets/images/register.png": "42428987d99e7acf8e10e4b83faeda8b",
"assets/assets/images/map.png": "66b6b2fe0895f8025aab3a2ce67706bc",
"assets/assets/images/home.png": "37c96aa533f744198b734364b81871ae",
"assets/assets/images/heart.png": "551c1d2a7dd9dcecf92710f24311101f",
"assets/assets/images/logo.png": "cde245e567e9e8949025d5e79865d59f",
"assets/assets/images/bus.svg": "538689ebe77258cc3c776c7b863b0cd5",
"assets/assets/images/profile.png": "84aa4430d0eb4a85b67d5cdf545e54fe",
"assets/assets/images/bus.png": "822d3f47cd873151d8afab6589f7efe1",
"assets/assets/images/login_big_image.png": "01ec67325f6957a3b0026c7764149c1f",
"assets/assets/icons/payment.svg": "c1030c96a245d36f4d0a82007870b18f",
"assets/assets/icons/workers.svg": "967b01602991257f5bd662a134dd7102",
"assets/assets/icons/train.png": "22cfe261c448e4ebf96436a510ab09a0",
"assets/assets/icons/user.svg": "90937dc86b69c1a24eaa72901e50c3e7",
"assets/assets/icons/home.svg": "843f7dbd912b7f984b7470eb13f404fe",
"assets/assets/icons/logout.svg": "e6827ac91443dc383fd5beb56022615b",
"assets/assets/icons/app_icon.png": "0642cf21b3b1b73e8c1d3c695a72b617",
"assets/assets/icons/fa.svg": "be831261621ff0e510531c5428133a38",
"assets/assets/icons/create_subaccount_modal_icon.svg": "545ffa55b19f912ec34576475ef354f4",
"assets/assets/icons/key.svg": "6dfc2b227704b483deccdf2af6263b2c",
"assets/assets/icons/settings.svg": "358efa4900ed29128f95888428726103",
"assets/assets/icons/train.svg": "c5709b8c05ccd616243056adff89aa13",
"assets/assets/icons/wallet.svg": "88ab28c1ed321c16e34daed8651a52bc",
"assets/assets/icons/dashboard.svg": "5769aa6ac4205709fcd339547ce7341a",
"assets/assets/icons/payout.svg": "83731a28e5d59f98a849bd178313f346",
"assets/assets/icons/update_icon.svg": "fe3aadf85f0c0639fa7c6a9533872518",
"assets/assets/icons/add.svg": "317af32adc3065545380442e09945d3d",
"assets/assets/icons/subaccount.svg": "03150e4ae216163cbebdd42cf1018143",
"assets/assets/icons/market.svg": "91c8dfdd78e09438cdceb533a885a082",
"assets/assets/icons/api.svg": "c937d483dc72fdc1994891fa9bd9f996",
"assets/assets/icons/image%25206.svg": "099a548bef2b25f2c7b9bcd205b526d9",
"assets/assets/icons/language.svg": "75fb8c5b69144303a292ef26c3d4c9c2",
"assets/assets/icons/exit.svg": "e3af9609a4efa0e61f40a17543850585",
"assets/assets/icons/delete.svg": "10934e838ecb6431110f8fe74a1b7f92",
"assets/assets/icons/hosting.svg": "1df5c961f924df3e1402f3f698c4211d",
"assets/assets/icons/profile.svg": "53ee3dd14e8bd86d5ed39163c98b6d55",
"assets/assets/icons/password.svg": "456d5d451311e0fefda781b06868fb86",
"assets/assets/icons/observer.svg": "a15e02b5443414dccce70cbb523e4f45",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

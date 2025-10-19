'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "274bc3dd12b451934a1a8ef4dceef8ae",
"assets/AssetManifest.bin.json": "9c3b1570eae222946039fda3cbada432",
"assets/AssetManifest.json": "d075f114088bd4f85aba48e746d364a3",
"assets/assets/images/agfa_printer_for.webp": "dafeb14cbcb65886f303b4d60cd5c28a",
"assets/assets/images/bp_machine_andon.webp": "ea94c964eb52ece3370692946bb8bcad",
"assets/assets/images/ct_scan_maintenance.webp": "c9bf17e95f77bc0dd9bac74ebcde797d",
"assets/assets/images/data_carbon_brush.webp": "0f627efef53c1419fc5ba2feee71470c",
"assets/assets/images/durico_thermal_paper.webp": "9d6767f7c1c8ed1ebf6e08b053851615",
"assets/assets/images/ecg_electrodes.webp": "665d5d21b3324aeaf5256605bbf3e286",
"assets/assets/images/endoscopy_sony_paper.webp": "bc6676fedf7389350a2fdf83b5636dd5",
"assets/assets/images/endoscopy_stent_system.webp": "6061961193068411c8ddb4e76929aca9",
"assets/assets/images/frequency_converter_for.webp": "41fb9a3522fe43c80e651801e294ff56",
"assets/assets/images/fuji_printer_for.webp": "ccd022225001e89607bb73a63cff1a28",
"assets/assets/images/hcg_strip.webp": "fcb6a29cb7a2df3fc072d3ff65c6c57e",
"assets/assets/images/hero_background.webp": "09dfaafd673bb2d57599901fa6328e51",
"assets/assets/images/lead_glass_ct.webp": "e3f1f14893dea4e29e1c7fe2ba7f6cc1",
"assets/assets/images/lead_glass_xray.webp": "8fd41b5426c6ced5364652101e490ffb",
"assets/assets/images/lead_sheet_1m.webp": "0eb9c2f6f3cb15aa8490b3d041464cb8",
"assets/assets/images/mri_mchine_maintaenance.webp": "e3bc7d47b8e6a7fbfef94fa1a1e4011d",
"assets/assets/images/oxygen_regulator_brand.webp": "6d92e6856eec662e1b0fc1324738e394",
"assets/assets/images/rota_deno_ag_cassette.webp": "99faf9ab79bbb2b94de295ca57f1b28a",
"assets/assets/images/sony_hybrid_printer.webp": "c9b8ddb2d13849cb5b1fb4b6d961db37",
"assets/assets/images/sony_ultrasound_thermal.webp": "dd30a8f74932e1c8b4a5b2cf1fc897cc",
"assets/assets/images/spectrum_logo.png": "446c6031e1f458bfde697692e02c5376",
"assets/assets/images/stool_container.webp": "9237fb312fae08578ce4e600309df5c1",
"assets/assets/images/syringe_for_ankee.webp": "45ad9771dc9060a69ed0342dd549625b",
"assets/assets/images/syringe_for_medrad.webp": "2f53e9abf11f76445c6cb6aaf28fe6e0",
"assets/assets/images/syringe_for_sinomed.webp": "0451a2b893b460106e6dbce565bc9a52",
"assets/assets/images/thermal_compatible_film.webp": "8da2fd512681c439dc923bace8bb9628",
"assets/assets/images/typhoid_ag.webp": "a134bb54bfc05a2c411c7560fea72659",
"assets/assets/images/urine_container.webp": "fbfc39fd21a504573d942feecbc3e7c3",
"assets/assets/images/urine_strips.webp": "033fd9b0901fdc93ecb18316980c2715",
"assets/assets/images/xray_machine_maintenance.webp": "438ac6c658407d2d2c2e9c6e96669f0e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "9e563b7ef56cd81d29fbe538fbdbe80a",
"assets/NOTICES": "c49030869ab90a415c7ce5d659f9f7f1",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"CNAME": "7b01ed92a6bb8160b3175f80b38b98fd",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "b8a1dfc6e6ec0d5f5cb636b73521e317",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "1ae4b5418df1970746a201207111ab1d",
"/": "1ae4b5418df1970746a201207111ab1d",
"main.dart.js": "6e9b5b7dc9756c3f03ef490dbf3c4385",
"manifest.json": "686cf8ed0df44bc86567ff069cf0e7bf",
"version.json": "ff4f591892afc3c6768f557b728f5486"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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

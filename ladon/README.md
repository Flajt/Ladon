# ladon

An opensource, free to use , Password Manager

# Motiviation

After the MYKI (a free to use password manager) has been aquired by a third party, I was toying with the idea of creating my own password manager just for fun, and so this is what I did. It's currently rather barebones, as I don't think it's worth implementing dozens of features if nobody uses it. Also I want to work on other projects as well, so my goal was to create an MVP.

# Free to use

Yes, this password manager is free to use, unlimited passwords and OTP tokens can be stored (as long as your device can manage it). All currently implemeneted features will stay **free for ever**! Maybe in the future I will add some paid features, however they will be purely optional (e.g. Checking if your password or email was in a databreach). 

# Features:
- Password generation: Generate secure passwords
- Autofill support: Enable it in the settings and you can autofill passwords everywhere
- OTP support: You can easily add support for OTP
- Simple Interface: The design is minimalistic so you can focus on what counts
- Backup: Backup your data to google drive (I plan on adding more in the future, if there is demand)
- Own your data: Import, export your data without an issue
- Search: Search you passwords via labels
- Offline first: Currently only service preview images are downloaded that's it.
- Privacy friendly: No tracking or analytics is embedded! (I consider building my own privacy friendly in the future)
- Opensource: As you can see it's Open Source XD

## Additional features

If you want to have additional features create an Issue and idealy a PR for it. At some point I will add some contribution guidelines as well. Also I'm not good with design, so any tips are appreciated as well.


## Techstack
- Framework: Flutter 
- Database: Hive (will be migrated soon)
- State management: BLOC

## Security

While I tried my best, this code **hasn't** been audited by security professionals. 
Currently the database is encrypted at rest with your master key, which is stored in a secure place, accessible only with your fingerprint (I can't see any biometric data, this is handled by your device). I will migrate this project in the future to Isar DB if it supports encryption, because the support for hive seems to have stopped.
<br>
Any additional security advice is welcome.



### Image Credits:
- Logo: free to download [pinterest.com](https://www.pinterest.de/pin/hydra-free-vector-icons-designed-by-freepik--168251736063434013/)
- <a href="https://www.flaticon.com/free-icons/thank-you" title="thank you icons">Thank you icons created by rsetiawan - Flaticon</a>
- <a href="https://www.flaticon.com/free-icons/key" title="key icons">Key icons created by Freepik - Flaticon</a>
- <a href="https://www.flaticon.com/free-icons/github" title="github icons">Github icons created by riajulislam - Flaticon</a>
- <a href="https://www.flaticon.com/free-icons/tax-free" title="tax free icons">Tax free icons created by Freepik - Flaticon</a>
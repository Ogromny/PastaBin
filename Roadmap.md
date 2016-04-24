# PastaBin Roadmap
## v0.1.0 (alpha)
* [x] Having a working website.

## v0.2.0 (beta)
* [x] Do a nice design and integrate it.
* [x] Add misc pages such as `about`, `api`, `contact`.
* [x] Rewrite `app.d` using vibe.WebInterface.
* [x] Rework the responsiveness focusing on content size, not device size.

## v0.3.0 (beta-2)
* [ ] Public pastes (no passwords) for the average user.
* [ ] Add, review and hard-test encryption algorithm.  
* [ ] Zero-knoweldge encryption would be a must.
* [ ] API system:
  * [ ] Auth by token for doing operations that need to write the db ;
  * [ ] Public API for getting Pastes and their meta-data.

## v0.4.0 (pre-launch)
* [ ] Support for syntax highlighting, done server-side. No JS needed.
* [ ] Support for expiration date:
  * [ ] 10 min ;
  * [ ] 1 day ;
  * [ ] 1 week ;
  * [ ] 1 month ;
  * [ ] 6 months ;
  * [ ] 1 year ;
  * [ ] indefinitly.
* [ ] Support for link shortening (ie. `pasta.pw/id`).

## v0.5.0 (first big update)
* [ ] Member area:
  * [ ] Social integrations (github, google, facebook) ;
  * [ ] Import/export pastes from/to GitHub Gist ;
  * [ ] Display the pastes list of the authenticated user.
* [ ] Support for paste visibility:
  * [ ] Public ;
  * [ ] Secret (access allowed only via link) ;
  * [ ] Private (no access except authorized accounts).
* [ ] Ability to backup/restore pastes  
  * [ ] Defining an import/export format ;
  * [ ] Export ;
  * [ ] Import.

## v0.6.0 (cross-compatibility)
* Tools to share a paste without using the website:
  * CLI Tools (terminal):
    * [ ] GNU/Linux ;
    * [ ] Apple OSX ;.
    * [ ] Windows.
  * GUI Tools:
    * [ ] GNU/Linux ;
    * [ ] Android ;
    * [ ] Apple OSX ;
    * [ ] Apple iOS ;
    * [ ] Windows ;
    * [ ] Windows Phone.

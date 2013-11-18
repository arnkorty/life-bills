# Be sure to restart your server when you modify this file.

LifeBills::Application.config.session_store :cookie_store, 
																						key: '_life_bills_session',
																						expire_after: 86400*90


---
annotation-target: "![[intro.pdf]]"
---
# Uniform Resource Locator (URL)  
Web resources are identified by a URL, defined by the following syntax:  

```
scheme://[user@]host[:port]path[?query][#fragment]  
```

- **scheme** identifies a protocol (normally: HTTP or HTTPS)  
- user contains authentication credentials, e.g., alice:secret  
- **host** identifies the remote server (via IP address or domain name)  
 - **port** is normally 80 for HTTP and 443 for HTTPS  
- **path** identifies the resource on the server (slash-separated strings)  
- **query** binds parameters to values (p1=v1&p2=v2...)
- **fragment** normally identifies a part of the HTML page (anchor) and is not sent to the server  

# URL Encoding  
#### URL encoding is a technique to encode arbitrary data into the ASCII  

###### Alphabet adopted in the syntax of URLs:  
- also required when using reserved characters like / and ? as literals, as opposed to their special meaning  
- URLs differing only by whether some unreserved character (like A) is URL-encoded or not are considered equivalent  
- the notion of “reserved” is context-dependent, e.g., / is reserved in  the path, but not in the query string (be careful!)  

```Example  
"This contains /" is encoded as "This%20contains%20%2F"
```


# Domain Names

#### On the Web, the server is typically identified by a string known as fully  
qualified domain name (FQDN).

##### Terminology  
- The string www.wikipedia.org is a FQDN and:  
- wikipedia.org is a domain name (or just domain for short)  
- www is a subdomain of the domain wikipedia.org  
- org is a top-level domain, like com or it

### The Domain Name System (DNS) protocol is used to resolve a domain name into an associated IP address, which identifies a single host.

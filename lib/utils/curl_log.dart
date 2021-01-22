import 'dart:convert';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  Future onError(DioError err) async {
    print("""ERROR:
    URL: ${err.request.uri}\n
    Method: ${err.request.method} 
    Headers: ${json.encode(err.response.headers.map)}
    StatusCode: ${err.response.statusCode}
    Data: ${json.encode(err.response.data)}
    <-- END HTTP
        """);
    return super.onError(err);
  }

  @override
  Future onRequest(RequestOptions options) async {
    print("""REQUEST:
    ${options.toCurlCmd()}
    """);
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) async {
    print("""RESPONSE:
    URL: ${response.request.uri}
    Method: ${response.request.method}
    Headers: ${json.encode(response.request.headers)}
    Data: ${json.encode(response.data)}
        """);
    return super.onResponse(response);
  }

  String cURLRepresentation(RequestOptions options) {
    List<String> components = ["\$ curl -i"];
    if (options.method != null && options.method.toUpperCase() == "GET") {
      components.add("-X ${options.method}");
    }

    if (options.headers != null) {
      options.headers.forEach((k, v) {
        if (k != "Cookie") {
          components.add("-H \"$k: $v\"");
        }
      });
    }

    var data = json.encode(options.data);
    if (data != null) {
      data = data.replaceAll('\"', '\\\"');
      components.add("-d \"$data\"");
    }

    components.add("\"${options.uri.toString()}\"");

    return components.join('\\\n\t');
  }
}

extension Curl on RequestOptions {
  String toCurlCmd() {
    String cmd = "curl";
    print(this.headers);

    String header = this
            .headers
            .map((key, value) {
              if (key == "content-type" &&
                  value.toString().indexOf("multipart/form-data") != -1) {
                value = "multipart/form-data;";
              }
              return MapEntry(key, "-H '$key: $value'");
            })
            .values
            .join(" ") ??
        "";
    String url = "${this.baseUrl ?? ""}${this.path}";
    if (this.queryParameters.length > 0) {
      String query = this
          .queryParameters
          .map((key, value) {
            return MapEntry(key, "$key=$value");
          })
          .values
          .join("&");

      url += (url.indexOf("?") != -1) ? query : "?$query";
    }
    if (this.method == "GET") {
      cmd += " $header '$url'";
    } else {
      Map<String, dynamic> files = {};
      String postData = "-d ''";
      if (data != null) {
        if (data is FormData) {
          FormData fdata = data as FormData;
          fdata.files.forEach((element) {
            MultipartFile file = element.value;
            files[element.key] = "@${file.filename}";
          });
          fdata.fields.forEach((element) {
            files[element.key] = element.value;
          });
          if (files.length > 0) {
            postData = files
                .map((key, value) => MapEntry(key, "-F '$key=$value'"))
                .values
                .join(" ");
          }
        } else if (data is Map<String, dynamic>) {
          files.addAll(data);

          if (files.length > 0) {
            if (contentType == "application/json") {
              postData = "-d '${json.encode(files).toString()}'";
            } else {
              String form = files
                  .map((key, value) => MapEntry(key, '$key=$value'))
                  .values
                  .join("&");
              postData = "-d '$form'";
            }
          }
        }
      }

      String method = this.method.toString();
      cmd += " -X $method $postData $header '$url'";
    }

    return cmd;
  }
}

package skynet.stress

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class HelloSimulation extends Simulation {

  val httpConf = http
    .baseURL("http://IP-NOT-SET-IN-SIMULATION-FILE") // FIXME routable IP
    .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
    .doNotTrackHeader("1")
    .acceptLanguageHeader("en-US,en;q=0.5")
    .acceptEncodingHeader("gzip, deflate")
    .userAgentHeader("Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0")

  val scn = scenario("HelloSimulation")
    .exec(http("request_1")
    .get("/"))
    //.pause(5)

  setUp(
    scn.inject(atOnceUsers(10000))
  ).protocols(httpConf)
}


import * as Sentry from "@sentry/node"
import { config } from "./core/config"

let _sentryEnabled = null

export const sentryEnabled = () => _sentryEnabled

export const setupSentry = () => {
    if (_sentryEnabled == null) {
        if (config.log.sentryDsn) {
            Sentry.init({ dsn: config.log.sentryDsn, environment: config.log.sentryEnv })
            _sentryEnabled = true
        } else {
            _sentryEnabled = false
        }
    }
}

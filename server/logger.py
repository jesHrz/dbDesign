import logging
import logging.config
import logging.handlers

LOG_FORMATTER = "%(asctime)s in %(name)s.%(funcName)s [%(levelname)s] %(message)s"
DATE_FORMATTER = "%d/%m%Y %H:%M:%S"


# logging.basicConfig(level=logging.INFO, format=LOG_FORMATTER, datefmt=DATE_FORMATTER)
# logging.config.fileConfig("config/logging.conf")

def GetLogger(name):
    logger = logging.getLogger(name)
    logger.setLevel(level=logging.INFO)
    handler = logging.FileHandler("logs/log.log")
    handler.setLevel(logging.INFO)
    formatter = logging.Formatter(LOG_FORMATTER, datefmt=DATE_FORMATTER)
    handler.setFormatter(formatter)

    console = logging.StreamHandler()
    console.setLevel(logging.INFO)

    log_file_handler = logging.handlers.TimedRotatingFileHandler(filename="logs/log", when="D", interval=1,
                                                                 backupCount=2)
    log_file_handler.suffix = "%Y-%m-%d.log"
    log_file_handler.setFormatter(formatter)
    log_file_handler.setLevel(logging.INFO)

    logger.addHandler(handler)
    logger.addHandler(console)
    logger.addHandler(log_file_handler)

    return logger

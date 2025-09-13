# SWI Deegree3 MapServer Configuration Docker Container

This Docker container automates the setup and execution of a [deegree](https://www.deegree.org/) web services instance.

---

## Environment Variables

| Variable                    | Description                                      | Required | Default Value                                      |
|-----------------------------|--------------------------------------------------|----------|----------------------------------------------------|
| `SWI_DEEGREE_ADMIN_PWD`     | Admin password for the deegree console.          | No       | None                                               |
| `SWI_DEEGREE_CONFIG_REPO`   | Git repository URL for the deegree configuration. | No       | `https://github.com/UNIS-Svalbard-Weather-Information/swi-deegree3-configuration.git` |
| `SWI_DEEGREE_REST_API_KEY` | API Key to communicate to use the RESTApi | No | None |

---

## Data Volume

- **`/root/data`**: Persistent data volume. Mount this volume to retain configuration and data between container restarts.
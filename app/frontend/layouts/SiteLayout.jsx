import { Head } from "@inertiajs/react"
import Navbar from "~/components/Navbar"
import FlashMessages from "~/components/FlashMessages"
const SiteLayout = ({ children }) => {

  return (
    <main>
      <Head title="Track your finances" />
      <Navbar />
      <FlashMessages />
      <div>{children}</div>
    </main>
  )
}

export default SiteLayout

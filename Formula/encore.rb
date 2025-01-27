class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.2"
    checksums = {
        "darwin_arm64" => "f8e1fe41a991c4a12e4f177052eb13378889bff64fb30e77ddddc8fc90541872",
        "darwin_amd64" => "24a2b65063563f40520ac977bd93ad46d7103120a90c0e678cdfc5a600e59b40",
        "linux_arm64"  => "ee3e33011f7a35f867de7bf3910861c914094e3d29c93d4b2c98a4d3b08e6087",
        "linux_amd64"  => "f12a4432a3fb5afd2eb1161b7534bf05d77d03a8d370e9605c0768e5b29dd8cf",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end

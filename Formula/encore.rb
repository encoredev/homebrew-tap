class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.7"
    checksums = {
        "darwin_arm64" => "34b302f22cc52ac80e4586f36d4a70a42c7fd798c3cf0d3b2e291613767e45f9",
        "darwin_amd64" => "7a33772a073ffe093201c2198ef0ed83bcedb2eb48a2b992c9643a98f396efb0",
        "linux_arm64"  => "0bcd39ec0cac2b67136a30d1fe669b9cb1b5a9c3c0792bf2cd0b235210fd1a9c",
        "linux_amd64"  => "2669b9abb77305b12cabc523fc719ec1af486a4ba7b45a02928c16ca2c288e1a",
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

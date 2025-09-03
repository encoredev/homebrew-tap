class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.49.3"
    checksums = {
        "darwin_arm64" => "77b171f9206509ad5910aab9f577f5d6b9bb2f0c7d99969af7161dd1fcc53641",
        "darwin_amd64" => "75f60407caeb3256707b7d27000b1fe88a796e27066963513e06369af6f41786",
        "linux_arm64"  => "fe3811f02796610931ad162c4d1408680af7e54300f562bb0349e2b0af605f73",
        "linux_amd64"  => "9bc64db28d8bceb683e7844e5d3e00811cc0e5decb7cd77c59d2be7fffb2620d",
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

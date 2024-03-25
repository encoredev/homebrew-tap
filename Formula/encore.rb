class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.4"
    checksums = {
        "darwin_arm64" => "91fad563a1e640ad043c946788e765886842451a99ccf93283fd184fef2bb444",
        "darwin_amd64" => "5d5099e51eecb8a0aea65cd25a1af8fae9c32a80ffa3f5578837c52a9a2f115e",
        "linux_arm64"  => "1cd73fd1a3d29faec0dfc9fa9b1e8422781fb083b723175789be9bb5348d8745",
        "linux_amd64"  => "69973d9e2f65d9157ff45f64d99330854834c38d22a0feb5a31fbf0ea8fbb6fd",
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

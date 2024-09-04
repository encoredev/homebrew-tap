class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.40.1"
    checksums = {
        "darwin_arm64" => "5b83f2147e1f4e490e86d309e62413b66c54c6b7c84504f26523f1b3c5218ea3",
        "darwin_amd64" => "d4e84301edab6125445a068775c182e5a054be8416f8e1e0530ec38944a89fb3",
        "linux_arm64"  => "6060c5fff6cec418f40b2b348bc9d5310490be1ee74fe731fa180032fe02cfbf",
        "linux_amd64"  => "551feb064a9b2bff84bd02796861bd91950df4d6e8e4468ec32b298cc1c247f2",
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

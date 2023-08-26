class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230826"
    checksums = {
        "darwin_arm64" => "04be635917313a427ac9f3ac6da9ad080be97c9bedb638cd9f680557bc250d9c",
        "darwin_amd64" => "db98b2a973a3c3304a03cba0c0d17987636bb14fe1fbcae1c04fb465e206d684",
        "linux_arm64"  => "97cd52d5803464d574e4750cd599b42f6dd906160606fc37dcc029ab0ce10d81",
        "linux_amd64"  => "44164d2e101475ef2a16c147e48a0aaff2f34027ef41eb087ba8556b270e5f8d",
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

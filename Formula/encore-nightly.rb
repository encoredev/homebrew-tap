class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221031"
    checksums = {
        "darwin_arm64" => "279a3c7bc5a8e8ac0d4ed2a67269eb896efc355a3243942efa653676bff24942",
        "darwin_amd64" => "39121e858a749889613cf5e37d1fb5d08831355e9d06a1ef85e2c0248e7b3dd5",
        "linux_arm64"  => "a8bc052558b62dcba649adf5fd42ebaf79057c83ff34b186ee59b059f1f600c9",
        "linux_amd64"  => "7b99342ed51a5253d6787556fb38550def32b098912d67b8db0bc32192b2fed4",
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
